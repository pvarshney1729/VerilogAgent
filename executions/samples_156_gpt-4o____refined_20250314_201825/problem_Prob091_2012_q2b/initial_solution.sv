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

        // State transition logic
        if (y[0]) begin
            // State A
            Y1 = w;
        end else if (y[1]) begin
            // State B
            if (w) begin
                Y1 = 1'b0;
            end else begin
                Y3 = 1'b1;
            end
        end else if (y[2]) begin
            // State C
            if (w) begin
                Y3 = 1'b0;
            end else begin
                Y3 = 1'b1;
            end
        end else if (y[3]) begin
            // State D
            if (w) begin
                Y3 = 1'b0;
            end else begin
                Y1 = 1'b0;
            end
        end else if (y[4]) begin
            // State E
            if (w) begin
                Y3 = 1'b0;
            end else begin
                Y3 = 1'b1;
            end
        end else if (y[5]) begin
            // State F
            if (w) begin
                Y3 = 1'b0;
            end else begin
                Y3 = 1'b1;
            end
        end
    end

endmodule