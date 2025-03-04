module TopModule (
    input logic clk,
    input logic rst_n,
    input logic x,
    input logic [2:0] y,
    output logic Y0,
    output logic z
);

    logic [2:0] Y; // Next state

    // Combinational logic for next state and output
    always @(*) begin
        case (y)
            3'b000: begin
                Y = (x == 1'b0) ? 3'b000 : 3'b001;
                z = 1'b0;
            end
            3'b001: begin
                Y = (x == 1'b0) ? 3'b001 : 3'b100;
                z = 1'b0;
            end
            3'b010: begin
                Y = (x == 1'b0) ? 3'b010 : 3'b001;
                z = 1'b0;
            end
            3'b011: begin
                Y = (x == 1'b0) ? 3'b001 : 3'b010;
                z = 1'b1;
            end
            3'b100: begin
                Y = (x == 1'b0) ? 3'b011 : 3'b100;
                z = 1'b1;
            end
            default: begin
                Y = 3'b000; // Default to a known state
                z = 1'b0;
            end
        endcase
    end

    // Sequential logic for state transition
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            Y <= 3'b000; // Reset state
        else
            Y <= Y;
    end

    // Output logic
    assign Y0 = Y[0];

endmodule