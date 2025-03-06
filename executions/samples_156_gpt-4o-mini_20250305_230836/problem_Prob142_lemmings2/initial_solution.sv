module TopModule (
    input logic clk,          
    input logic areset,       
    input logic bump_left,    
    input logic bump_right,   
    input logic ground,       
    output logic walk_left,   
    output logic walk_right,  
    output logic aaah         
);

typedef enum logic [1:0] {
    WALK_LEFT = 2'b00,
    WALK_RIGHT = 2'b01,
    FALL_LEFT = 2'b10,
    FALL_RIGHT = 2'b11
} state_t;

state_t current_state, next_state;

always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= WALK_LEFT;
    end else begin
        current_state <= next_state;
    end
end

always_comb begin
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    
    case (current_state)
        WALK_LEFT: begin
            walk_left = 1;
            if (bump_left || (bump_left && bump_right && ground)) begin
                next_state = WALK_RIGHT;
            end else if (!ground) begin
                next_state = FALL_LEFT;
            end else begin
                next_state = WALK_LEFT;
            end
        end
        
        WALK_RIGHT: begin
            walk_right = 1;
            if (bump_right || (bump_left && bump_right && ground)) begin
                next_state = WALK_LEFT;
            end else if (!ground) begin
                next_state = FALL_RIGHT;
            end else begin
                next_state = WALK_RIGHT;
            end
        end
        
        FALL_LEFT: begin
            aaah = 1;
            if (ground) begin
                next_state = WALK_LEFT;
            end else begin
                next_state = FALL_LEFT;
            end
        end
        
        FALL_RIGHT: begin
            aaah = 1;
            if (ground) begin
                next_state = WALK_RIGHT;
            end else begin
                next_state = FALL_RIGHT;
            end
        end
        
        default: next_state = WALK_LEFT; // Default case to avoid latches
    endcase
end

endmodule