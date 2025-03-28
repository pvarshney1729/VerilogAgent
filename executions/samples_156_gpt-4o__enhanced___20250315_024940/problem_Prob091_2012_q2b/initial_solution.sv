module TopModule (
    input logic [5:0] y,
    input logic w,
    output logic Y1,
    output logic Y3
);

    // State transition logic
    always @(*) begin
        // Default values for Y1 and Y3
        Y1 = 1'b0;
        Y3 = 1'b0;

        // Determine the next state based on current state and input w
        case (y)
            6'b000001: begin // State A
                if (w) begin
                    Y1 = 1'b1; // Transition to B
                end
            end
            6'b000010: begin // State B
                if (w) begin
                    Y1 = 1'b1; // Transition to C
                end else begin
                    Y3 = 1'b1; // Transition to D
                end
            end
            6'b000100: begin // State C
                if (w) begin
                    Y1 = 1'b1; // Transition to E
                end else begin
                    Y3 = 1'b1; // Transition to D
                end
            end
            6'b001000: begin // State D
                if (w) begin
                    Y1 = 1'b1; // Transition to F
                end
            end
            6'b010000: begin // State E
                if (!w) begin
                    Y3 = 1'b1; // Transition to D
                end
            end
            6'b100000: begin // State F
                if (w) begin
                    Y1 = 1'b1; // Transition to C
                end else begin
                    Y3 = 1'b1; // Transition to D
                end
            end
        endcase
    end

endmodule