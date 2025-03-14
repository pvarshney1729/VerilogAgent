module TopModule(
    input logic clk,       // Clock signal, positive edge-triggered
    input logic areset,    // Asynchronous active-high reset
    input logic x,         // Input signal, 1-bit
    output logic z         // Output signal, 1-bit
);

    // State encoding using one-hot
    typedef enum logic [1:0] {
        A = 2'b01,
        B = 2'b10
    } state_t;

    state_t state, next_state;

    // State transition and output logic
    always @(*) begin
        case (state)
            A: begin
                if (x) begin
                    next_state = B;
                    z = 1;
                end else begin
                    next_state = A;
                    z = 0;
                end
            end
            B: begin
                if (x) begin
                    next_state = B;
                    z = 0;
                end else begin
                    next_state = B;
                    z = 1;
                end
            end
            default: begin
                next_state = A;
                z = 0;
            end
        endcase
    end

    // State register with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
            z <= 0;
        end else begin
            state <= next_state;
        end
    end

endmodule