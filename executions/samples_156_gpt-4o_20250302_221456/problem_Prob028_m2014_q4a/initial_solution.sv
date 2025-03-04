module TopModule(
    input logic d,
    input logic ena,
    output logic q
);

    always @(*) begin
        if (ena) 
            q = d;  // Data is captured when enable is high
        // q retains its value when enable is low
    end

endmodule