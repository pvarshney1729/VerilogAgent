module TopModule(
    input logic clk,
    input logic [7:0] in,
    output logic [7:0] anyedge
);
    // Internal register to store the previous state of 'in'
    logic [7:0] prev_in;

    // Sequential logic to capture the previous state and detect edges
    always_ff @(posedge clk) begin
        // Detect any edge by comparing current 'in' with 'prev_in'
        anyedge <= in ^ prev_in;
        // Update 'prev_in' with the current state of 'in'
        prev_in <= in;
    end

endmodule