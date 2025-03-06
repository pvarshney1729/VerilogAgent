module TopModule (
    input wire clk,       // Clock signal, positive edge-triggered
    input wire areset,    // Asynchronous reset, active high
    input wire x,         // Input signal
    output reg z          // Output signal
);

    // State encoding using one-hot
    localparam STATE_A = 2'b01;
    localparam STATE_B = 2'b10;

    reg [1:0] state, next_state;

    // State transition logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_A;
        end else begin
            state <= next_state;
        end
    end

    // Next state and output logic
    always @(*) begin
        case (state)
            STATE_A: begin
                if (x) begin
                    next_state = STATE_B;
                    z = 1;
                end else begin
                    next_state = STATE_A;
                    z = 0;
                end
            end
            STATE_B: begin
                if (x) begin
                    next_state = STATE_B;
                    z = 0;
                end else begin
                    next_state = STATE_B;
                    z = 1;
                end
            end
            default: begin
                next_state = STATE_A;
                z = 0;
            end
        endcase
    end

endmodule