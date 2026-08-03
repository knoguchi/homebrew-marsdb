# homebrew-marsdb

Homebrew tap for [MarsDB](https://github.com/knoguchi/marsdb), an embeddable
property-graph database with an openCypher query subset.

## Install

```
brew install knoguchi/marsdb/marsdb
```

Or tap first, then install:

```
brew tap knoguchi/marsdb
brew install marsdb
```

Recent Homebrew versions block loading a formula from a newly-tapped,
not-yet-trusted tap the first time — if you hit `Refusing to load formula
... from untrusted tap`, run `brew trust knoguchi/marsdb` once and retry.

This installs the `marsdb` CLI (builds from the published crates.io source
via `cargo install`, so it needs the `rust` build dependency — Homebrew
pulls that in automatically).

```
$ marsdb :memory:
MarsDB graph database. Enter Cypher statements terminated by `;`. Ctrl-D to exit.
marsdb> CREATE (a:Person {name: 'Alice'})-[:KNOWS]->(b:Person {name: 'Bob'});
marsdb> MATCH (a:Person)-[:KNOWS]->(b:Person) RETURN a.name, b.name;
```

See the [main repo](https://github.com/knoguchi/marsdb) for the Rust library
and Python bindings.

## Documentation

`brew help`, `man brew`, or [Homebrew's documentation](https://docs.brew.sh).
