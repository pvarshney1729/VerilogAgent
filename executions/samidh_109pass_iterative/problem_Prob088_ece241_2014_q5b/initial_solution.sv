module TopModule (
    input logic clk,
    input logic areset, // Asynchronous active-high reset
    input logic x,
    output logic z
);

    // State encoding
    localparam logic [1:0] state_A = 2'b01;
    localparam logic [1:0] state_B = 2'b10;

    logic [1:0] state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= state_A;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            state_A: begin
                if (x == 0) begin
                    next_state = state_A;
                    z = 0;
                end else begin
                    next_state = state_B;
                    z = 1;
                end
            end
            state_B: begin
                if (x == 0) begin
                    next_state = state_B;
                    z = 1;
                end else begin
                    next_state = state_B;
                    z = 0;
                end
            end
            default: begin
                next_state = state_A;
                z = 0;
            end
        endcase
    end

endmodule