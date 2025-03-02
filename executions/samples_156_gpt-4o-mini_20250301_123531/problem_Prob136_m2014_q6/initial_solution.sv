module TopModule (
    input logic clk,
    input logic reset,
    input logic w,
    output logic z
);

    typedef enum logic [2:0] {
        A = 3'b001,
        B = 3'b010,
        C = 3'b011,
        D = 3'b100,
        E = 3'b101,
        F = 3'b110
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= A;
            z <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        case (current_state)
            A: begin
                next_state = (w == 1'b0) ? B : A;
                z = 0;
            end
            B: begin
                next_state = (w == 1'b0) ? C : D;
                z = 0;
            end
            C: begin
                next_state = (w == 1'b0) ? E : D;
                z = 0;
            end
            D: begin
                next_state = (w == 1'b0) ? F : A;
                z = 0;
            end
            E: begin
                next_state = (w == 1'b0) ? E : D;
                z = 1;
            end
            F: begin
                next_state = (w == 1'b0) ? C : D;
                z = 1;
            end
            default: begin
                next_state = A;
                z = 0;
            end
        endcase
    end

endmodule