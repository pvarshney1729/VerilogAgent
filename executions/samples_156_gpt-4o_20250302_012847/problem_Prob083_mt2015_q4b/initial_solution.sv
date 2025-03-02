module refined_design (
    input  logic        clk,
    input  logic        reset,
    input  logic [3:0]  a,
    input  logic [3:0]  b,
    output logic [3:0]  z
);

    logic [3:0] z_next;

    // Combinational logic to determine the next state of z
    always @(*) begin
        z_next = a & b; // Example operation, modify as needed
    end

    // Sequential logic with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            z <= 4'b0000;
        end else begin
            z <= z_next;
        end
    end

endmodule