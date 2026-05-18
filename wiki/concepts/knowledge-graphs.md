---
description: "Knowledge graphs are structured representations of entities and their relationships. The general concept — RDF triples, ontologies, graph databases. The education-specific version is where it gets interesting."
tags: [concept, knowledge-graph, semantic-web, ontology, graph-database]
sources: []
created: 2026-05-16
updated: 2026-05-16
---

# Knowledge Graphs

A knowledge graph is a collection of entities and the relationships between them. "Paris is the capital of France." "Fractions require understanding of division." "Skill A is a prerequisite for Skill B." The structure is always the same — nodes and edges — but what you put in them and what you use them for varies wildly.

The general concept spans semantic web (RDF, OWL, SPARQL), enterprise knowledge management, search engines (Google's Knowledge Graph), and graph databases (Neo4j). The common thread: representing knowledge as a network of relationships instead of a pile of documents.

## The Education-Specific Version

[[knowledge-graph-education]] is the applied version that matters for this vault. Same structure, different domain:

| General KG | Education KG |
|-----------|-------------|
| Entity: "Paris" | Node: "Add fractions with unlike denominators" |
| Relation: "is capital of" | Edge: "requires mastery of" |
| Property: "population: 2.1M" | Property: "CCSS alignment: 5.NF.A.1" |

The education version has a directional bias that general knowledge graphs don't: prerequisite edges flow one way. You can't learn C before B before A. This makes traversal and sequencing algorithmically tractable in a way that general graph reasoning isn't.

The open thread: general knowledge graphs (like what powers LLM-augmented RAG) are about *information retrieval* — find the right fact. Educational knowledge graphs are about *learning pathways* — find the right sequence. Different design problem, different evaluation criteria, and it's why dumping a general-purpose KG into an ed-tech product doesn't work. The structure has to encode pedagogical relationships, not just semantic ones.
