module TopModule (
    input wire clk,          // Clock signal, active edge specified below
    input wire load,         // Load control signal, active high
    input wire ena,          // Enable control signal, active high
    input wire [1:0] amount, // Shift amount and direction control
    input wire [63:0] data,  // Data input for loading into shift register
    output reg [63:0] q      // Output of shift register
);

    // Initialize q to 0
    initial begin
        q = 64'b0;
    end

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else if (ena) begin
            case (amount)
                2'b00: q <= q << 1;
                2'b01: q <= q << 8;
                2'b10: q <= q >>> 1; // Arithmetic shift
                2'b11: q <= q >>> 8; // Arithmetic shift
                default: q <= q; // Handle undefined cases
            endcase
        end
    end

endmodule