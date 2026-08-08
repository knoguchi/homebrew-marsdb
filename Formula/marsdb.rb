class Marsdb < Formula
  desc "Embeddable property-graph database with an openCypher query subset"
  homepage "https://github.com/knoguchi/marsdb"
  url "https://static.crates.io/crates/marsdb-cli/marsdb-cli-0.8.0.crate"
  sha256 "4b9e3c0dc3faefae7cc22973a14cee17ebe0db8ffde5d5c3fc9a919f8a16b9d0"
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
