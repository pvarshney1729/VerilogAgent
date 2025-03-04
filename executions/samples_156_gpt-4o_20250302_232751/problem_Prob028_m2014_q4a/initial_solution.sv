module TopModule (
    input logic d,
    input logic ena,
    output logic q
);
    always @(*) begin
        if (ena) begin
            q = d;  // Capture the input 'd' when 'ena' is high
        end
        // When 'ena' is low, 'q' retains its previous value
    end
endmodule