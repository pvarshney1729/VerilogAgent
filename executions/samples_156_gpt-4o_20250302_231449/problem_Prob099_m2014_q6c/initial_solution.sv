module TopModule (
    input logic [5:0] y,
    input logic w,
    input logic clk,
    input logic reset_n,
    output logic Y1,
    output logic Y3,
    output logic Y2,
    output logic Y4
);

    // State transition logic
    logic [5:0] next_state;

    always @(*) begin
        // Default next state is the current state
        next_state = y;
        case (y)
            6'b000001: next_state = (w == 1'b0) ? 6'b000010 : 6'b000001; // State A
            6'b000010: next_state = (w == 1'b0) ? 6'b000100 : 6'b001000; // State B
            6'b000100: next_state = (w == 1'b0) ? 6'b010000 : 6'b001000; // State C
            6'b001000: next_state = (w == 1'b0) ? 6'b100000 : 6'b000001; // State D
            6'b010000: next_state = (w == 1'b0) ? 6'b010000 : 6'b001000; // State E
            6'b100000: next_state = (w == 1'b0) ? 6'b000100 : 6'b001000; // State F
            default: next_state = 6'b000001; // Default to State A
        endcase
    end

    // Sequential logic for state update
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            y <= 6'b000001; // Reset to State A
        else
            y <= next_state;
    end

    // Output logic
    always @(*) begin
        Y1 = 1'b0;
        Y3 = 1'b0;
        Y2 = next_state[1];
        Y4 = next_state[3];
        
        case (y)
            6'b000001: begin
                Y1 = 1'b0;
                Y3 = 1'b0;
            end
            6'b000010: begin
                Y1 = 1'b1;
                Y3 = 1'b0;
            end
            6'b000100: begin
                Y1 = 1'b0;
                Y3 = 1'b1;
            end
            6'b001000: begin
                Y1 = 1'b1;
                Y3 = 1'b1;
            end
            6'b010000: begin
                Y1 = 1'b0;
                Y3 = 1'b0;
            end
            6'b100000: begin
                Y1 = 1'b1;
                Y3 = 1'b0;
            end
        endcase
    end

endmodule