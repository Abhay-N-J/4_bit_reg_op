# Four–bit Register Operation
Four D flip–flops and Four 4 × 1 Multiplexers with mode selection inputs s1 and s0. 
The Register operates according to the values of select lines, 
if s1s0=00 => no change, 
   s1s0=01 => complement output, 
   s1s0=10 => shift the bits to the right, 
   s1s0=11 => shift the bits to left

To run
  ```
  iverilog -o sample_name tb_proj.v
  ```
  ```
  vvp sample_name
  ```
  ```
  gtkwave tb_proj.vcd // The dump file name
  ```
