module TopModule (
    input logic clk,
    input logic resetn,
    input logic [1:0] byteena,
    input logic [15:0] d,
    output logic [15:0] q
);

    // Internal register to hold the state of the flip-flops
    logic [15:0] q_reg;

    // Sequential logic block triggered on the positive edge of the clock
    always @(posedge clk) begin
        if (!resetn) begin
            // Synchronous active-low reset: set all flip-flops to 0
            q_reg <= 16'b0;
        end else begin
            // Byte-enable logic
            if (byteena[0]) begin
                q_reg[7:0] <= d[7:0];  // Update lower byte if byteena[0] is high
            end
            if (byteena[1]) begin
                q_reg[15:8] <= d[15:8]; // Update upper byte if byteena[1] is high
            end
        end
    end

    // Assign the internal register to the output
    assign q = q_reg;

endmodule