module TopModule (
    input logic [5:0] y,
    input logic w,
    output logic Y1,
    output logic Y2,
    output logic Y3,
    output logic Y4
);

    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition
    always @(posedge w or posedge y) begin
        if (y != 6'b000001 && y != 6'b000010 && y != 6'b000100 && 
            y != 6'b001000 && y != 6'b010000 && y != 6'b100000) begin
            current_state <= A; // Reset to state A on invalid y
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            A: next_state = (w == 0) ? B : A;
            B: next_state = (w == 0) ? C : D;
            C: next_state = (w == 0) ? E : D;
            D: next_state = (w == 0) ? F : A;
            E: next_state = (w == 0) ? E : D;
            F: next_state = (w == 0) ? C : D;
            default: next_state = A; // Default to state A
        endcase
    end

    // Output logic
    always @(*) begin
        Y1 = (current_state == E || current_state == F);
        Y3 = (current_state == D);
        Y2 = (current_state == B);
        Y4 = (current_state == D);
    end

    // Initialize outputs
    initial begin
        Y1 = 0;
        Y2 = 0;
        Y3 = 0;
        Y4 = 0;
    end

endmodule