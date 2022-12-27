#[rustler::nif]
fn echo(string: &str) -> &str {
    string
}

rustler::init!("Elixir.ElixirRust.Rustler", [echo]);
