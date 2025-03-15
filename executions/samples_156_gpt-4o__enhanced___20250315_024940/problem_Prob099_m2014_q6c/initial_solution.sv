module TopModule (
    input  logic [5:0] y,  // 6-bit input representing the state
    input  logic w,        // 1-bit input signal
    output logic Y1,       // 1-bit output signal
    output logic Y3        // 1-bit output signal
);

    // Next-state logic for Y2 and Y4 based on the current state y and input w
    always @(*) begin
        // Default values
        Y1 = 1'b0; // Initialize Y1
        Y3 = 1'b0; // Initialize Y3

        // Logic for Y2 (next-state signal corresponding to y[1])
        if (y[0]) begin // State A
            Y1 = (w == 1'b0) ? 1'b1 : 1'b0; // Transition to B if w=0
        end else if (y[1]) begin // State B
            Y1 = (w == 1'b0) ? 1'b1 : 1'b0; // Transition to C if w=0
        end else if (y[2]) begin // State C
            Y1 = (w == 1'b0) ? 1'b1 : 1'b0; // Transition to E if w=0
        end else if (y[3]) begin // State D
            Y1 = (w == 1'b0) ? 1'b1 : 1'b0; // Transition to F if w=0
        end else if (y[4]) begin // State E
            Y1 = 1'b0; // Remain in E, Y1 = 0
        end else if (y[5]) begin // State F
            Y1 = 1'b0; // Transition to C if w=0
        end

        // Logic for Y3 (next-state signal corresponding to y[3])
        if (y[0]) begin // State A
            Y3 = (w == 1'b1) ? 1'b1 : 1'b0; // Remain in A if w=1
        end else if (y[1]) begin // State B
            Y3 = (w == 1'b1) ? 1'b1 : 1'b0; // Transition to D if w=1
        end else if (y[2]) begin // State C
            Y3 = (w == 1'b1) ? 1'b1 : 1'b0; // Transition to D if w=1
        end else if (y[3]) begin // State D
            Y3 = 1'b0; // Remain in D, Y3 = 0
        end else if (y[4]) begin // State E
            Y3 = (w == 1'b1) ? 1'b1 : 1'b0; // Transition to D if w=1
        end else if (y[5]) begin // State F
            Y3 = (w == 1'b1) ? 1'b1 : 1'b0; // Transition to D if w=1
        end
    end
endmodule