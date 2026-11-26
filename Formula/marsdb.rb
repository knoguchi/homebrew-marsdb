class Marsdb < Formula
  desc "Embeddable property-graph database with an openCypher query subset"
  homepage "https://github.com/knoguchi/marsdb"
  url "https://static.crates.io/crates/marsdb-cli/marsdb-cli-0.11.0.crate"
  sha256 "99c243f784507fda8ae83d6e500b8cfd3c793ee306ac381e900b4afde9d1241b"
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
