module TopModule (
    input  wire clk,      // Clock signal, active on rising edge
    input  wire areset,   // Asynchronous reset, active high
    input  wire j,        // Input signal j
    input  wire k,        // Input signal k
    output reg  out       // Output signal reflecting current state
);

    // State encoding
    localparam OFF = 1'b0;
    localparam ON  = 1'b1;

    // State register
    reg state;

    // Asynchronous reset and state transition logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= OFF;
        end else begin
            case (state)
                OFF: begin
                    if (j) state <= ON;
                end
                ON: begin
                    if (k) state <= OFF;
                end
            endcase
        end
    end

    // Output logic
    always @(*) begin
        case (state)
            OFF: out = 1'b0;
            ON:  out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule