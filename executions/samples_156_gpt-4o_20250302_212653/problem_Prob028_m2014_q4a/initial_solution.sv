module TopModule (
    input logic d,   // Data input
    input logic ena, // Enable input
    output logic q   // Output
);

    always @(*) begin
        if (ena) begin
            q = d;
        end
        // If ena is low, q retains its value
    end

endmodule