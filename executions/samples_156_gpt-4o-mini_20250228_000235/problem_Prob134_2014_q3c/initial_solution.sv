module TopModule (
    input logic clk,
    input logic x,
    input logic [2:0] y,
    output logic Y0,
    output logic z
);

    logic [2:0] next_state;
    logic [2:0] current_state;

    // State update logic
    always @(posedge clk) begin
        current_state <= (current_state == 3'b000 && x == 1'b0) ? 3'b000 :
                         (current_state == 3'b000 && x == 1'b1) ? 3'b001 :
                         (current_state == 3'b001 && x == 1'b0) ? 3'b001 :
                         (current_state == 3'b001 && x == 1'b1) ? 3'b100 :
                         (current_state == 3'b010 && x == 1'b0) ? 3'b010 :
                         (current_state == 3'b010 && x == 1'b1) ? 3'b001 :
                         (current_state == 3'b011 && x == 1'b0) ? 3'b001 :
                         (current_state == 3'b011 && x == 1'b1) ? 3'b010 :
                         (current_state == 3'b100 && x == 1'b0) ? 3'b011 :
                         (current_state == 3'b100 && x == 1'b1) ? 3'b100 : 
                         current_state; // Retain current state if no condition matches
    end

    // Output logic
    always @(*) begin
        Y0 = next_state[0];
        z = (current_state == 3'b011 && x == 1'b1) ? 1'b1 : 1'b0;
    end

    // Initialize current state
    initial begin
        current_state = 3'b000;
    end

endmodule