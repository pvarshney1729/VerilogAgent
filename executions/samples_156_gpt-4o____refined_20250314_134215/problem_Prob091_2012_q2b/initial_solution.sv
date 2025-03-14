module TopModule (
    input logic [5:0] y,
    input logic w,
    output logic Y1,
    output logic Y3
);

    always @(*) begin
        // Default assignments
        Y1 = 1'b0;
        Y3 = 1'b0;

        // State transition logic for Y1 and Y3
        if (y[0]) begin // State A
            Y1 = w;
        end else if (y[1]) begin // State B
            Y1 = ~w;
        end else if (y[2]) begin // State C
            Y3 = ~w;
        end else if (y[3]) begin // State D
            Y3 = w;
        end else if (y[4]) begin // State E
            Y3 = ~w;
        end else if (y[5]) begin // State F
            Y1 = w;
        end
    end

endmodule