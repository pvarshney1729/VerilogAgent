module TopModule(
    input logic clk,
    input logic x,
    input logic [2:0] y,
    output logic Y0,
    output logic z
);

    logic [2:0] next_state;

    // Combinational logic for next state and output
    always @(*) begin
        case (y)
            3'b000: begin
                next_state = (x == 1'b0) ? 3'b000 : 3'b001;
                z = 1'b0;
            end
            3'b001: begin
                next_state = (x == 1'b0) ? 3'b001 : 3'b100;
                z = 1'b0;
            end
            3'b010: begin
                next_state = (x == 1'b0) ? 3'b010 : 3'b001;
                z = 1'b0;
            end
            3'b011: begin
                next_state = (x == 1'b0) ? 3'b001 : 3'b010;
                z = 1'b1;
            end
            3'b100: begin
                next_state = (x == 1'b0) ? 3'b011 : 3'b100;
                z = 1'b1;
            end
            default: begin
                next_state = 3'b000;
                z = 1'b0;
            end
        endcase
    end

    // Sequential logic for state update
    always_ff @(posedge clk) begin
        y <= next_state;
    end

    // Output Y0 is the least significant bit of the next state
    assign Y0 = next_state[0];

endmodule