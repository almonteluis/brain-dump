---
description: Update frontend color definitions from Figma design system
tags: [work, frontend, design-system, TEAME]
sources: [TEAME-169.md]
created: 2026-04-30
updated: 2026-04-30
---

# TEAME-169: Update Color Definitions in Frontend

**Source:** TEAME-169.md
**Date ingested:** 2026-04-30
**Type:** Jira ticket
**Status:** To Do (since 2025-09-30, carried over Sprint 44/45)
**Priority:** High
**Assignee:** Luis Almonte
**Reporter:** Sam Saarinen
**Sprint:** Team E Sprint 44, 45
**URL:** https://newclassrooms.atlassian.net/browse/TEAME-169

## Summary

Update frontend color definitions to match the design team's Figma design system. Ticket has been in "To Do" status since September 2025 — longest-running open ticket in backlog.

## Parent

- **PP-369**: Update Skill Selection Layouts and Navigation (Epic, In Progress, Highest Priority)

## Blockers

- Figma design handoff — link in source ticket
- Requires functional testing + LTS feature flag

## Key Details

| Field | Value |
|-------|-------|
| Type | Story |
| Labels | Functional Testing, LTS Feature |
| Linked repos | 2 GitHub repositories |
| Linked branches | 2 GitHub branches |
| Created | September 30, 2025 |

## Notes

- Part of the "Update Skill Selection Layouts and Navigation" epic
- Requires coordination with design team for Figma handoff
- Will need functional testing and LTS feature flag integration

## Colors lifted from figma
Codigo  
@theme {  
--color-yellow-100: #FFE697;  
--color-yellow-300: #FFD349;  
--color-yellow-500: #FDB814;  
--color-yellow-800: #624e00;  
--color-neutral-0: #FFFFFF;  
--color-neutral-50: #F9F8F5;  
--color-neutral-100: #E9E9E9;  
--color-neutral-200: #E1E1E1;  
--color-neutral-300: #D3D3D3;  
--color-neutral-400: #a6a6a6;  
--color-neutral-500: #9C9B9B;  
--color-neutral-600: #7c7c7c;  
--color-neutral-700: #686868;  
--color-neutral-800: #555555;  
--color-neutral-900: #424242;  
--color-neutral-950: #393939;  
--color-blue-50: #B7E2FF;  
--color-blue-300: #0A9AF8;  
--color-blue-500: #1259fb;  
--color-blue-800: #17275D;  
--color-blue-900: #191559;  
--color-emerald-50: #D5FFF3;  
--color-emerald-100: #ABFEE7;  
--color-emerald-200: #6DFED4;  
--color-emerald-300: #07F0B9;  
--color-emerald-400: #00D492;  
--color-emerald-500: #02B683;  
--color-emerald-600: #02976D;  
--color-emerald-700: #017957;  
--color-emerald-800: #015B41;  
--color-emerald-900: #013D2C;  
--color-emerald-950: #001E16;  
--color-lime-50: #F0FEDF;  
--color-lime-100: #D7FEA0;  
--color-lime-200: #BCF54A;  
--color-lime-300: #B0E646;  
--color-lime-400: #94C239;  
--color-lime-500: #79A02D;  
--color-lime-600: #5F7E22;  
--color-lime-700: #455C15;  
--color-lime-800: #2E3F0C;  
--color-lime-900: #182304;  
--color-lime-950: #0E1602;  
--color-amber-50: #FFF5EB;  
--color-amber-100: #FFE7CE;  
--color-amber-200: #FFCF8F;  
--color-amber-300: #FCB815;  
--color-amber-400: #D69C0E;  
--color-amber-500: #D69C0E;  
--color-amber-600: #8B6408;  
--color-amber-700: #694B03;  
--color-amber-800: #493302;  
--color-amber-900: #291B01;  
--color-amber-950: #1C1100;  
--color-sky-50: #daf6fe;  
--color-sky-100: #b8eefd;  
--color-sky-200: #3edefb;  
--color-sky-300: #35c2db;  
--color-sky-400: #2ba4b9;  
--color-sky-500: #22889a;  
--color-sky-600: #196a78;  
--color-sky-700: #10505c;  
--color-sky-800: #093840;  
--color-sky-900: #031f24;  
--color-sky-950: #011317;  
--color-red-50: #fceded;  
--color-red-100: #fadbdb;  
--color-red-200: #f5b7b7;  
--color-red-300: #f29090;  
--color-red-400: #f06767;  
--color-red-500: #e33434;  
--color-red-600: #b82828;  
--color-red-700: #891b1b;  
--color-red-800: #611111;  
--color-red-900: #3c0707;  
--color-red-950: #290303;  
--color-purple-50: #F4EEFD;  
--color-purple-100: #ECE1FC;  
--color-purple-200: #D9C2F9;  
--color-purple-300: #C79FF6;  
--color-purple-400: #B77EF3;  
--color-purple-500: #A95AF0;  
--color-purple-600: #992FE5;  
--color-purple-700: #7522B0;  
--color-purple-800: #4F1479;  
--color-purple-900: #2E084A;  
--color-purple-950: #200435;  
--color-pink-50: #fdedf1;  
--color-pink-100: #fbdae3;  
--color-pink-200: #f7b8ca;  
--color-pink-300: #f490b0;  
--color-pink-400: #f26599;  
--color-pink-500: #e33480;  
--color-pink-600: #b72866;  
--color-pink-700: #891b4b;  
--color-pink-800: #621134;  
--color-pink-900: #3a061c;  
--color-pink-950: #280312;  
--color-orange-50: #fdedea;  
--color-orange-100: #fcdbd3;  
--color-orange-200: #f9b7a3;  
--color-orange-300: #f8946d;  
--color-orange-400: #e77231;  
--color-orange-500: #c05e27;  
--color-orange-600: #9a4a1d;  
--color-orange-700: #763714;  
--color-orange-800: #51240a;  
--color-orange-900: #311304;  
--color-orange-950: #210b02;  
--color-green-50: #c0fdea;  
--color-green-100: #76fcd9;  
--color-green-200: #4ee3c0;  
--color-green-300: #42c5a6;  
--color-green-400: #38aa8f;  
--color-green-500: #2e9079;  
--color-green-600: #23725f;  
--color-green-700: #175546;  
--color-green-800: #0e3c31;  
--color-green-900: #05221b;  
--color-green-950: #02140f;  
--color-stone-50: #F7F3F0;  
--color-stone-100: #EBE4DC;  
--color-stone-200: #D9CCB9;  
--color-stone-300: #BAAF9F;  
--color-stone-400: #9f9486;  
--color-stone-500: #847b6f;  
--color-stone-600: #666056;  
--color-stone-700: #4e4841;  
--color-stone-800: #36322c;  
--color-stone-900: #1D1B18;  
--color-stone-950: #12110E;  
--color-indigo-50: #eef0ff;  
--color-indigo-100: #e1e4fe;  
--color-indigo-200: #c2c9fe;  
--color-indigo-300: #9fabfd;  
--color-indigo-400: #7d91fd;  
--color-indigo-500: #5776fc;  
--color-indigo-600: #1259fb;  
--color-indigo-700: #0a41bd;  
--color-indigo-800: #052b86;  
--color-indigo-900: #021753;  
--color-indigo-950: #010f3c;  
}