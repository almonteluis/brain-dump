---
description: HTTP protocol fundamentals including TCP three-way handshake, HTTP/2 improvements with binary framing and multiplexing, and the evolution from HTTP/1.
tags: ["FrameTypes", "Internet"]
---
>HTTP (Hypertext Transfer Protocol) is the foundation of data communication on the World Wide Web. It’s an application-layer protocol that defines how messages are formatted and transmitted between web browsers and servers. HTTP operates on a request-response model: clients (usually web browsers) send requests to servers, which then respond with the requested data. The protocol is stateless, meaning each request is independent of any previous requests. HTTP supports various methods (GET, POST, PUT, DELETE, etc.) for different types of interactions with resources. HTTPS is the secure version of HTTP, using encryption to protect data in transit. HTTP/2 and HTTP/3 are more recent versions, offering improved performance through features like multiplexing and header compression. Understanding HTTP is crucial for web development, as it underpins how web applications communicate and function.

HTTP is a TCP/IP-based application layer communication protocol that standardizes how clients and servers communicate with each other. It defines how content is requested and transmitted across the internet.

By default, TCP port 80 is used, but other ports can also be used. HTTPS, however, uses port 443.

Three way handshake followed by a slow-start. This only applies to HTTP/1

3-way handshake in it's simples form is that all the TCP connections begin with a three-way handshake in which the client and the server share a series of packets before starting to share the application data.
- `SYN` - Cient picks a random number, let's say x, and sends its to the server
- `SYN ACK` - Server acknowledges the request by sending an ACK packet back to the client which is made up of a random number, let's say y picked up by server and the number x+1 where x is the number that was sent by the client.
- `ACK` - Client increments the number y received from the server and sends an ACK packet back with the number y+1

![[Pasted image 20250128183138.png]]

## HTTP/2 - 2015

HTTP/2 was designed for low latency transport of content. The key features or differences from the old version of HTTP/1.1 include

- Binary instead of Textual
- Multiplexing - Multiple asynchronous HTTP requests over a single connection
- Header compression using HPACK
- Server Push - Multiple responses for single request
- Request Prioritization
- Security

### 1. Binary Protocol

HTTP/2 tends to address the issue of increased latency that existed in HTTP/1.x by making it a binary protocol. The major building blocks of HTTP/2 are Frames and Streams

#### Frames and Streams

HTTP messages are now composed of one or more frames. There is a HEADERS frame for the meta data and DATA frame for the payload and there exist several other types of frames (HEADERS, DATA, RST_STREAM, SETTINGS, PRIORITY etc) that you can check through [the HTTP/2 specs](https://http2.github.io/http2-spec/#FrameTypes).

### 2. Multiplexing

Since HTTP/2 is now a binary protocol and it uses frames and streams for requests and responses, once a TCP connection is opened, all the streams are sent asynchronously through the same connection without opening any additional connections. And in turn, the server responds in the same asynchronous way i.e. the response has no order and the client uses the assigned stream id to identify the stream to which a specific packet belongs. This also solves the head-of-line blocking issue that existed in HTTP/1.x i.e. the client will not have to wait for the request that is taking time and other requests will still be getting processed. 

#Internet
