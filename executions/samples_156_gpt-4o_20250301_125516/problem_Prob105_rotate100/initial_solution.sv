module TopModule (
    input  wire        clk,       // Clock input
    input  wire        load,      // Synchronous active high load signal
    input  wire [1:0]  ena,       // Synchronous enable signal, 2 bits
    input  wire [99:0] data,      // Input data, 100 bits
    output reg  [99:0] q          // Output data, 100 bits
);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            case (ena)
                2'b01: q <= {q[0], q[99:1]};  // Rotate right
                2'b10: q <= {q[98:0], q[99]}; // Rotate left
                default: q <= q;              // Hold current value
            endcase
        end
    end

endmodule