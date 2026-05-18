---
description: "Time-of-check to time-of-use"
tags: ['research']
source: "https://en.wikipedia.org/wiki/Time-of-check_to_time-of-use"
raw_file: "Time-of-check to time-of-use.md"
created: 2026-05-17
---

In [software development](https://en.wikipedia.org/wiki/Software_development "Software development"), **time-of-check to time-of-use** (**TOCTOU**, **TOCTTOU** or **TOC/TOU**) is a class of [software bugs](https://en.wikipedia.org/wiki/Software_bug "Software bug") caused by a [race condition](https://en.wikipedia.org/wiki/Race_condition "Race condition") involving the *checking* of the state of a part of a system (such as a security credential) and the *use* of the results of that check.

TOCTOU race conditions are common in [Unix](https://en.wikipedia.org/wiki/Unix "Unix") between operations on the [file system](https://en.wikipedia.org/wiki/File_system#Metadata "File system"),[^1] but can occur in other contexts, including local [sockets](https://en.wikipedia.org/wiki/Unix_domain_socket "Unix domain socket") and improper use of [database transactions](https://en.wikipedia.org/wiki/Database_transaction "Database transaction"). In the early 1990s, the mail utility of BSD 4.3 UNIX had an [exploitable](https://en.wikipedia.org/wiki/Exploit_\(computer_security\) "Exploit (computer security)") race condition for temporary files because it used the `mktemp()` [^2] function.[^3] Early versions of [OpenSSH](https://en.wikipedia.org/wiki/OpenSSH "OpenSSH") had an exploitable race condition for [Unix domain sockets](https://en.wikipedia.org/wiki/Unix_domain_sockets "Unix domain sockets").[^4] They remain a problem in modern systems; as of 2019, a TOCTOU race condition in [Docker](https://en.wikipedia.org/wiki/Docker_\(software\) "Docker (software)") allows root access to the filesystem of the host platform.[^5] In the 2023 [Pwn2Own](https://en.wikipedia.org/wiki/Pwn2Own "Pwn2Own") competition in Vancouver, a team of hackers were able to compromise the gateway in an updated [Tesla Model 3](https://en.wikipedia.org/wiki/Tesla_Model_3 "Tesla Model 3") using this bug.[^6] In 2025, a TOCTOU race condition in [Amazon Web Services](https://en.wikipedia.org/wiki/Amazon_Web_Services "Amazon Web Services") ' [DNS](https://en.wikipedia.org/wiki/Domain_Name_System "Domain Name System") management system for [DynamoDB](https://en.wikipedia.org/wiki/Amazon_DynamoDB "Amazon DynamoDB") caused a major outage across the US-EAST-1 region. The incident stemmed from outdated DNS plans being applied after newer ones had already been cleaned up, resulting in the deletion of endpoint [IP addresses](https://en.wikipedia.org/wiki/IP_address "IP address") and widespread service failure.[^7]

## Description

A program is vulnerable to a TOCTOU race condition if it does the following

1. Checks some property or validates some data
2. Takes some action based on this information

and the following are the case

1. Non-atomic: It's possible for other programs that run concurrently with this program to execute in between steps 1 and 2
2. Outside control: Other programs can change the property or data

Then, if another process does in fact change the property between step 1 and 2, step 2 is performed based on outdated information, which can have unintended consequences.

If the program running is privileged, and an unprivileged process can affect the property, it can effectively execute certain privileged tasks.

In particular, if the property checks whether some action is allowed, and thereby implements a security boundary, such as a permissions check, this permissions check can then be bypassed completely, and a variety of privileged actions can be executed this way ([privilege escalation](https://en.wikipedia.org/wiki/Privilege_escalation "Privilege escalation")).

## Examples

In [Unix](https://en.wikipedia.org/wiki/Unix "Unix"), the following [C](https://en.wikipedia.org/wiki/C_\(programming_language\) "C (programming language)") code, when used in a `setuid` program, has a TOCTOU bug:

```
if (access("file", W_OK) != 0) {
    exit(1);
}

fd = open("file", O_WRONLY);
write(fd, buffer, sizeof(buffer));
```

Here, *access* is intended to check whether the real user who executed the `setuid` program would normally be allowed to write the file (i.e., `*access*` checks the [real userid](https://en.wikipedia.org/wiki/Real_userid "Real userid") rather than [effective userid](https://en.wikipedia.org/wiki/Effective_userid "Effective userid")).

This race condition is vulnerable to an attack:

| Victim | Attacker |
| --- | --- |
| ``` if (access("file", W_OK) != 0) {     exit(1); } ``` |  |
|  | After the access check, before the open, the attacker replaces `file` with a [symlink](https://en.wikipedia.org/wiki/Symlink "Symlink") to the Unix password file `/etc/passwd`:  ``` symlink("/etc/passwd", "file"); ``` |
| ``` fd = open("file", O_WRONLY); write(fd, buffer, sizeof(buffer)); ```  Actually writing over `/etc/passwd` |  |

In this example, an attacker can exploit the race condition between the `access` and `open` to trick the `setuid` victim into overwriting an entry in the system password database. TOCTOU races can be used for [privilege escalation](https://en.wikipedia.org/wiki/Privilege_escalation "Privilege escalation") to get administrative access to a machine.

Although this sequence of events requires precise timing, it is possible for an attacker to arrange such conditions without too much difficulty.

The implication is that applications cannot assume the state managed by the operating system (in this case the file system namespace) will not change between system calls.

## Reliably timing TOCTOU

Exploiting a TOCTOU race condition requires precise timing to ensure that the attacker's operations interleave properly with the victim's. In the example above, the attacker must execute the `symlink` [system call](https://en.wikipedia.org/wiki/System_call "System call") precisely between the `access` and `open`. For the most general attack, the attacker must be scheduled for execution after each operation by the victim, also known as "single-stepping" the victim.

In the case of BSD 4.3 mail utility and `mktemp()`,[^2] the attacker can simply keep launching mail utility in one process, and keep guessing the [temporary file](https://en.wikipedia.org/wiki/Temporary_file "Temporary file") names and keep making symlinks in another process. The attack can usually succeed in less than one minute.

Techniques for single-stepping a victim program include file system mazes [^8] and algorithmic complexity attacks.[^9] In both cases, the attacker manipulates the OS state to control scheduling of the victim.

File system mazes force the victim to read a directory entry that is not in the OS cache, and the OS puts the victim to sleep while it is reading the directory from disk. Algorithmic complexity attacks force the victim to spend its entire scheduling quantum inside a single system call traversing the kernel's [hash table](https://en.wikipedia.org/wiki/Hash_table "Hash table") of cached file names. The attacker creates a very large number of files with names that hash to the same value as the file the victim will look up.

## Preventing TOCTOU

Despite conceptual simplicity, TOCTOU race conditions are difficult to avoid and eliminate. One general technique is to use error handling instead of pre-checking, under the philosophy of EAFP – "It is easier to ask for forgiveness than permission" – rather than LBYL – "look before you leap". In this case there is no check, and failure of assumptions to hold are signaled by an error being returned.[^10]

In the context of file system TOCTOU race conditions, the fundamental challenge is ensuring that the file system cannot be changed between two system calls. In 2004, an impossibility result was published, showing that there was no portable, deterministic technique for avoiding TOCTOU race conditions when using the Unix `access` and `open` filesystem calls.[^11]

Since this impossibility result, libraries for tracking [file descriptors](https://en.wikipedia.org/wiki/File_descriptor "File descriptor") and ensuring correctness have been proposed by researchers.[^12]

An alternative solution proposed in the research community is for Unix systems to adopt [transactions](https://en.wikipedia.org/wiki/Transaction_processing "Transaction processing") in the file system or the OS kernel. Transactions provide a [concurrency control](https://en.wikipedia.org/wiki/Concurrency_control "Concurrency control") abstraction for the OS, and can be used to prevent TOCTOU races. While no production Unix kernel has yet adopted transactions, proof-of-concept research prototypes have been developed for Linux, including the Valor file system [^13] and the TxOS kernel.[^14] [Microsoft Windows](https://en.wikipedia.org/wiki/Microsoft_Windows "Microsoft Windows") has added transactions to its [NTFS](https://en.wikipedia.org/wiki/NTFS "NTFS") file system,[^15] but Microsoft discourages their use, and has indicated that they may be removed in a future version of Windows.[^16]

[File locking](https://en.wikipedia.org/wiki/File_locking "File locking") is a common technique for preventing race conditions for a single file, but it does not extend to the file system namespace and other metadata, nor does locking work well with networked filesystems, and cannot prevent TOCTOU race conditions.

For `setuid` binaries, a possible solution is to use the `seteuid()` system call to change the effective user and then perform the `open()` call. Differences in `setuid()` between operating systems can be problematic.[^17]

## Real-world consequences

TOCTOU vulnerabilities have caused significant outages in large-scale systems. In October 2025, AWS experienced a major disruption due to a race condition in its DNS management system for DynamoDB. The incident involved outdated DNS plans being applied after newer ones had already been cleaned up, leading to the deletion of endpoint IPs and widespread service failure.[^18]

[^1]: Wei, Jinpeng; Pu, Calton (December 2005). ["TOCTTOU Vulnerabilities in UNIX-Style File Systems: An Anatomical Study"](https://www.usenix.org/conference/fast-05/tocttou-vulnerabilities-unix-style-file-systems-anatomical-study). [USENIX](https://en.wikipedia.org/wiki/USENIX "USENIX"). Retrieved 2019-01-14.

[^2]: ["mktemp(3)"](https://man7.org/linux/man-pages/man3/mktemp.3.html). *Linux manual page*. 2017-09-15.

[^3]: Shangde Zhou(周尚德) (1991-10-01). ["A Security Loophole in Unix"](http://cdblp.cn/paper/UNIX%E7%9A%84%E4%B8%80%E4%B8%AA%E6%BC%8F%E6%B4%9E/94334.html).

[^4]: Acheson, Steve (1999-11-04). ["The Secure Shell (SSH) Frequently Asked Questions"](https://web.archive.org/web/20170213004928/http://www.employees.org/~satch/ssh/faq/TheWholeSSHFAQ.html). Archived from [the original](http://www.employees.org/~satch/ssh/faq/TheWholeSSHFAQ.html) on 2017-02-13.

[^5]: ["Docker Bug Allows Root Access to Host File System"](https://duo.com/decipher/docker-bug-allows-root-access-to-host-file-system). *Decipher*. Duo Security. 28 May 2019. Retrieved 2019-05-29.

[^6]: ["Windows 11, Tesla, Ubuntu, and macOS hacked at Pwn2Own 2023"](https://www.bleepingcomputer.com/news/security/windows-11-tesla-ubuntu-and-macos-hacked-at-pwn2own-2023/). *BleepingComputer*. Retrieved 2023-03-24.

[^7]: ["AWS Service Event in the US-EAST-1 Region"](https://aws.amazon.com/message/101925/). *Amazon Web Services*. 2025-10-27. Retrieved 2025-10-30.

[^8]: Borisov, Nikita; Johnson, Rob; Sastry, Naveen; Wagner, David (August 2005). "Fixing races for fun and profit: how to abuse atime". *Proceedings of the 14th Conference on USENIX Security Symposium*. **14**. Baltimore, MD: USENIX Association: 303–314. [CiteSeerX](https://en.wikipedia.org/wiki/CiteSeerX_\(identifier\) "CiteSeerX (identifier)") [10.1.1.117.7757](https://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.117.7757).

[^9]: Xiang Cai; Yuwei Gui; Johnson, Rob (May 2009). ["Exploiting Unix File-System Races via Algorithmic Complexity Attacks"](https://web.archive.org/web/20210518212029/https://www3.cs.stonybrook.edu/~rob/papers/races2.pdf) (PDF). *2009 30th IEEE Symposium on Security and Privacy*. Berkeley, CA: IEEE Computer Society. pp. 27–41. [doi](https://en.wikipedia.org/wiki/Doi_\(identifier\) "Doi (identifier)"):[10.1109/SP.2009.10](https://doi.org/10.1109%2FSP.2009.10). [ISBN](https://en.wikipedia.org/wiki/ISBN_\(identifier\) "ISBN (identifier)") [978-0-7695-3633-0](https://en.wikipedia.org/wiki/Special:BookSources/978-0-7695-3633-0 "Special:BookSources/978-0-7695-3633-0"). [S2CID](https://en.wikipedia.org/wiki/S2CID_\(identifier\) "S2CID (identifier)") [6393789](https://api.semanticscholar.org/CorpusID:6393789). Archived from [the original](https://www3.cs.stonybrook.edu/~rob/papers/races2.pdf) (PDF) on 2021-05-18.

[^10]: [Martelli, Alex](https://en.wikipedia.org/wiki/Alex_Martelli "Alex Martelli") (2006). "Chapter 6: Exceptions". *Python in a Nutshell* (2 ed.). [O'Reilly Media](https://en.wikipedia.org/wiki/O%27Reilly_Media "O'Reilly Media"). p. 134. [ISBN](https://en.wikipedia.org/wiki/ISBN_\(identifier\) "ISBN (identifier)") [978-0-596-10046-9](https://en.wikipedia.org/wiki/Special:BookSources/978-0-596-10046-9 "Special:BookSources/978-0-596-10046-9").

[^11]: Dean, Drew; Hu, Alan J. (August 2004). "Fixing Races for Fun and Profit: How to use access(2)". *Proceedings of the 13th USENIX Security Symposium*. San Diego, CA): 195–206. [CiteSeerX](https://en.wikipedia.org/wiki/CiteSeerX_\(identifier\) "CiteSeerX (identifier)") [10.1.1.83.8647](https://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.83.8647).

[^12]: Tsafrir, Dan; Hertz, Tomer; Wagner, David; [Da Silva, Dilma](https://en.wikipedia.org/wiki/Dilma_Da_Silva "Dilma Da Silva") (June 2008). ["Portably Preventing File Race Attacks with User-Mode Path Resolution"](https://dominoweb.draco.res.ibm.com/c4028924309762d18525746e004a4feb.html). *Technical Report RC24572, [IBM T. J. Watson Research Center](https://en.wikipedia.org/wiki/Thomas_J._Watson_Research_Center "Thomas J. Watson Research Center")*. Yorktown Heights, NY.

[^13]: Spillane, Richard P.; Gaikwad, Sachin; Chinni, Manjunath; Zadok, Erez (February 24–27, 2009). ["Enabling Transactional File Access via Lightweight Kernel Extensions"](https://www.fsl.cs.sunysb.edu/docs/valor/valor_fast2009.pdf) (PDF). *Seventh USENIX Conference on File and Storage Technologies (FAST 2009)*. San Francisco, CA.

[^14]: Porter, Donald E.; Hofmann, Owen S.; Rossbach, Christopher J.; Benn, Alexander; Witchel, Emmett (October 11–14, 2009). ["Operating System Transactions"](https://www.sigops.org/s/conferences/sosp/2009/papers/porter-sosp09.pdf) (PDF). *Proceedings of the 22nd [ACM](https://en.wikipedia.org/wiki/Association_for_Computing_Machinery "Association for Computing Machinery") Symposium on Operating Systems Principles (SOSP '09)*. Big Sky, MT.

[^15]: Russinovich, Mark; Solomon, David A. *Windows Internals*. [Microsoft Press](https://en.wikipedia.org/wiki/Microsoft_Press "Microsoft Press"). [ISBN](https://en.wikipedia.org/wiki/ISBN_\(identifier\) "ISBN (identifier)") [978-0735648739](https://en.wikipedia.org/wiki/Special:BookSources/978-0735648739 "Special:BookSources/978-0735648739").

[^16]: ["Alternatives to using Transactional NTFS"](https://web.archive.org/web/20220929200925/https://learn.microsoft.com/en-us/windows/win32/fileio/deprecation-of-txf). *[Microsoft Developer Network](https://en.wikipedia.org/wiki/Microsoft_Developer_Network "Microsoft Developer Network")*. Archived from [the original](https://docs.microsoft.com/en-us/windows/win32/fileio/deprecation-of-txf) on 29 September 2022. Retrieved 10 December 2015.

[^17]: Hao Chen; Wagner, David; Dean, Drew (2002-05-12). ["Setuid Demystified"](https://people.eecs.berkeley.edu/~daw/papers/setuid-usenix02.pdf) (PDF).

[^18]: ["AWS Service Event in the US-EAST-1 Region"](https://aws.amazon.com/message/101925/). *Amazon Web Services*. 2025-10-27. Retrieved 2025-10-30.
