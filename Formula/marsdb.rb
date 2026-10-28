class Marsdb < Formula
  desc "Embeddable property-graph database with an openCypher query subset"
  homepage "https://github.com/knoguchi/marsdb"
  url "https://static.crates.io/crates/marsdb-cli/marsdb-cli-0.10.0.crate"
  sha256 "9af4234ebb45699a1f61f9c6a4f9ea09a90a0cb77f0d1cd9e0bc39614b1dba69"
  license any_of: ["Apache-2.0", "MIT"]

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    (testpath/"query.cypher").write <<~CYPHER
      CREATE (a:Person {name: 'Alice'});
      MATCH (n) RETURN n.name
    CYPHER
    output = shell_output("#{bin}/marsdb :memory: \"$(cat #{testpath}/query.cypher)\"")
    assert_match "Alice", output
  end
end
