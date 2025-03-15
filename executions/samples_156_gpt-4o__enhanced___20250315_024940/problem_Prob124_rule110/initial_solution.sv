module TopModule (
    input  logic clk,
    input  logic load,
    input  logic [511:0] data,
    output logic [511:0] q
);

    // Intermediate storage for next state
    logic [511:0] next_q;

    // Always block for updating the state on clock edge
    always @(posedge clk) begin
        if (load) begin
            q <= data;  // Load new data if load signal is high
        end else begin
            // Compute next state based on Rule 110
            next_q[0]   = 0;                              // q[-1] is considered as 0
            next_q[511] = 0;                              // q[512] is considered as 0
            
            for (int i = 0; i < 511; i++) begin
                next_q[i+1] = ( (q[i] == 1 && q[i+1] == 1 && (i == 0 ? 0 : q[i-1] == 1)) ? 0 :
                                 (q[i] == 1 && (i == 0 ? 0 : q[i-1] == 0) && q[i+1] == 1) ? 1 :
                                 (q[i] == 1 && (i == 0 ? 0 : q[i-1] == 1) && q[i+1] == 0) ? 1 :
                                 (q[i] == 1 && (i == 0 ? 0 : q[i-1] == 0) && q[i+1] == 0) ? 0 :
                                 (q[i] == 0 && q[i+1] == 1 && (i == 0 ? 0 : q[i-1] == 1)) ? 1 :
                                 (q[i] == 0 && q[i+1] == 0 && (i == 0 ? 0 : q[i-1] == 0)) ? 0 :
                                 (q[i] == 0 && q[i+1] == 1 && (i == 0 ? 0 : q[i-1] == 0)) ? 1 :
                                 (q[i] == 0 && (i == 0 ? 0 : q[i-1] == 0) && (q[i+1] == 0)) ? 0 : 0) ) );
            end
            
            // Update the state to the next state
            q <= next_q;
        end
    end

    // Initialize q to 0 in simulation
    initial begin
        q = 512'b0;  // All cells off
    end

endmodule