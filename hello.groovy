// def example1() {
//   println 'Hello from example1 function !\n'
// }

def example2() {
  // println 'Hello from example2 function\n'
  def proc = 'bash hello.sh'.execute()
  def b = new StringBuffer()
  println proc.text
  println b.toString()
}

// return this