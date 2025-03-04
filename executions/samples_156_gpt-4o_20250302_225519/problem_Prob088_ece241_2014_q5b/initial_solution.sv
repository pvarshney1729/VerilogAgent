module TopModule (
    input logic clk,       // Clock signal, positive edge-triggered
    input logic areset,    // Asynchronous active-high reset
    input logic x,         // Input signal, 1-bit
    output logic z         // Output signal, 1-bit
);

    typedef enum logic [1:0] {
        STATE_A = 2'b01,
        STATE_B = 2'b10
    } state_t;

    state_t state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_A;
            z <= 0;
        end else begin
            case (state)
                STATE_A: begin
                    if (x) begin
                        state <= STATE_B;
                        z <= 1;
                    end else begin
                        state <= STATE_A;
                        z <= 0;
                    end
                end
                STATE_B: begin
                    if (x) begin
                        state <= STATE_B;
                        z <= 0;
                    end else begin
                        state <= STATE_B;
                        z <= 1;
                    end
                end
                default: begin
                    state <= STATE_A;
                    z <= 0;
                end
            endcase
        end
    end

endmodule