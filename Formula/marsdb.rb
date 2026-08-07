class Marsdb < Formula
  desc "Embeddable property-graph database with an openCypher query subset"
  homepage "https://github.com/knoguchi/marsdb"
  url "https://static.crates.io/crates/marsdb-cli/marsdb-cli-0.7.1.crate"
  sha256 "78de635df3053521b9335044937b5d72b904be3e3e58f7977b705fddf82ab9fd"
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
