```verilog
module TopModule (
    input  logic [254:0] in_vector, // 255-bit input vector
    output logic [7:0]   out_count  // 8-bit output count
);

    // Combinational Logic for Population Count
    integer i;
    logic [7:0] count;

    always @(*) begin
        count = 8'b0; // Initialize count to zero
        for (i = 0; i < 255; i = i + 1) begin
            count = count + in_vector[i];
        end
    end

    assign out_count = count;

endmodule
```