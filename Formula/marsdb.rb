class Marsdb < Formula
  desc "Embeddable property-graph database with an openCypher query subset"
  homepage "https://github.com/knoguchi/marsdb"
  url "https://static.crates.io/crates/marsdb-cli/marsdb-cli-0.5.0.crate"
  sha256 "49611bca5e1ba0254904bc739f1bbc1de6c47c04c615a43cd7b65db8506089fc"
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
