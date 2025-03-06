module TopModule (
    input logic clk,            // Clock signal, positive edge-triggered
    input logic areset,         // Asynchronous active-high reset
    input logic x,              // Input signal
    output logic z              // Output signal
);
    typedef enum logic [1:0] {
        A = 2'b01,
        B = 2'b10
    } state_t;

    state_t current_state, next_state;

    // Asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= A;
            z <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state and output
    always @(*) begin
        case (current_state)
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
endmodule