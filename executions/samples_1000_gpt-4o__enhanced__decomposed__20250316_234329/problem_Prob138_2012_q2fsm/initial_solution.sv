module TopModule(
    input logic clk,
    input logic reset,
    input logic w,
    output logic z
);

    // State encoding using localparam
    localparam logic [2:0] A = 3'b000,
                           B = 3'b001,
                           C = 3'b010,
                           D = 3'b011,
                           E = 3'b100,
                           F = 3'b101;

    // State register
    logic [2:0] current_state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (current_state)
            A: next_state = (w) ? B : A;
            B: next_state = (w) ? C : D;
            C: next_state = (w) ? E : D;
            D: next_state = (w) ? F : A;
            E: next_state = (w) ? E : D;
            F: next_state = (w) ? C : D;
            default: next_state = A; // Default to state A
        endcase
    end

    // State register update (sequential)
    always @(posedge clk) begin
        if (reset) begin
            current_state <= A; // Reset to state A
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic for z (combinational)
    always @(*) begin
        case (current_state)
            E, F: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule