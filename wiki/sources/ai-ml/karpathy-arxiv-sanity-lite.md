---
tags:
  - arxiv
  - machine-learning
  - paper
  - clippings
sources:
  - karpathyarxiv-sanity lite tag arxiv papers of interest get recommendations of similar papers in a nice UI using SVMs over tfidf feature vectors based on paper abstracts..md
created: 2026-04-29
updated: 2026-04-29
---

# karpathy/arxiv-sanity-lite

**Source:** karpathyarxiv-sanity lite tag arxiv papers of interest get recommendations of similar papers in a nice UI using SVMs over tfidf feature vectors based on paper abstracts..md
**Date ingested:** 2026-04-29
**Type:** Tool documentation

## Summary

Lightweight arXiv paper recommender. Polls arXiv API for new papers, lets users tag papers of interest, recommends new papers per tag using SVMs over TF-IDF features of abstracts.

## Key Features

- Periodic polling of arXiv API for new papers
- User tagging system for areas of interest
- SVM-based recommendations per tag using TF-IDF of abstracts
- Search, rank, sort, slice results in web UI
- Daily email digest of new recommendations
- Live at [arxiv-sanity-lite.com](https://arxiv-sanity-lite.com/)

## Architecture

- `arxiv_daemon.py` — downloads new papers via arXiv API
- `compute.py` — computes TF-IDF features
- `serve.py` — Flask server
- `send_emails.py` — daily digest (optional, requires SendGrid)
- Database stored in `data/` directory (sqlitedict)

## Deployment

- Runs on smallest Linode "Nanode 1 GB" instance
- $5/month for ~30K papers indexed
- Cron job for periodic updates

## Entities Mentioned

- [[andrej-karpathy|Andrej Karpathy]] — Creator

## Concepts Covered

- [[paper-recommendation]] — SVM + TF-IDF for academic paper discovery
- [[arxiv]] — Preprint server for scientific papers
- [[tfidf]] — Term frequency-inverse document frequency for text features
