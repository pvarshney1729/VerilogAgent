```verilog
module TopModule (
    input logic [3:0] input_vector,
    output logic [1:0] pos
);
    always_comb begin
        casez (input_vector)
            4'b1???: pos = 2'b11; // MSB 1
            4'b01??: pos = 2'b10; // Second MSB 1
            4'b00?1: pos = 2'b01; // Third MSB 1
            4'b0001: pos = 2'b00; // LSB 1
            default: pos = 2'b00; // No active input
        endcase
    end
endmodule
```