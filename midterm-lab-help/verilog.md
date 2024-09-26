Here’s a cheat sheet for Verilog syntax that should be helpful for your FPGA lab exam. It covers the essential constructs, operators, and common patterns used in Verilog design.

### Verilog Syntax Cheat Sheet

#### 1. **Modules**
```verilog
module <module_name> (
    input <input_type> <input_name>,
    output <output_type> <output_name>,
    // other ports
);
    // Internal declarations
    <data_type> <variable_name>;
    
    // Behavioral or structural code

endmodule
```

#### 2. **Data Types**
- **Net Types:**
  - `wire`: Represents connections.
  - `tri`, `wor`: Tri-state and wired-OR.

- **Register Types:**
  - `reg`: Holds value; can be assigned in procedural blocks.
  - `integer`, `real`: For numerical values.

#### 3. **Operators**
- **Arithmetic Operators:** `+`, `-`, `*`, `/`, `%`
- **Relational Operators:** `==`, `!=`, `<`, `>`, `<=`, `>=`
- **Logical Operators:** `&&`, `||`, `!`
- **Bitwise Operators:** `&`, `|`, `^`, `~`, `<<`, `>>`
  
#### 4. **Assign Statements**
```verilog
assign <wire_name> = <expression>; // Continuous assignment
```

#### 5. **Procedural Blocks**
- **Always Block:**
```verilog
always @(sensitivity_list) begin
    // Sequential code
end
```
- **Initial Block:**
```verilog
initial begin
    // Initialization code
end
```

#### 6. **Conditional Statements**
- **If-Else:**
```verilog
if (<condition>) begin
    // code
end else begin
    // code
end
```
- **Case Statement:**
```verilog
case (<expression>)
    <case_value1>: begin
        // code
    end
    <case_value2>: begin
        // code
    end
    default: begin
        // code
    end
endcase
```

#### 7. **Loops**
- **For Loop:**
```verilog
for (integer i = 0; i < N; i = i + 1) begin
    // code
end
```
- **While Loop:**
```verilog
while (<condition>) begin
    // code
end
```
- **Repeat Loop:**
```verilog
repeat (N) begin
    // code
end
```

#### 8. **Functions and Tasks**
- **Function:**
```verilog
function <return_type> <function_name> (input <type> <arg1>, ...);
    // code
    return <value>;
endfunction
```
- **Task:**
```verilog
task <task_name> (input <type> <arg1>, ...);
    // code
endtask
```

#### 9. **Timing Controls**
- **Delay:**
```verilog
#<time_delay> // e.g., #10ns
```
- **Event Control:**
```verilog
@(posedge <signal>); // Wait for rising edge
```

#### 10. **Instantiation**
```verilog
<module_name> instance_name (
    .<port_name>(<signal_name>),
    // other ports
);
```

#### 11. **Comments**
- **Single Line:** `// comment`
- **Multi-line:** `/* comment */`

#### 12. **Finite State Machines (FSM) Example**
```verilog
typedef enum logic [1:0] {
    S0, S1, S2
} state_t;

state_t current_state, next_state;

always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n)
        current_state <= S0;
    else
        current_state <= next_state;
end

always_comb begin
    case (current_state)
        S0: next_state = S1;
        S1: next_state = S2;
        S2: next_state = S0;
        default: next_state = S0;
    endcase
end
```

#### 13. **Testbench Example**
```verilog
module tb_<module_name>;
    // Testbench signals
    reg clk;
    reg reset_n;
    // Instantiate the design under test
    <module_name> dut (
        .clk(clk),
        .reset_n(reset_n),
        // other ports
    );

    initial begin
        // Testbench code
        // Initialize signals
        reset_n = 0;
        #5 reset_n = 1;
        // Add more test cases
    end
    
    always #5 clk = ~clk; // Clock generation
endmodule
```

### Tips
- Always check your sensitivity lists in `always` blocks.
- Use non-blocking assignments (`<=`) for sequential logic and blocking assignments (`=`) for combinational logic.
- Make sure to include reset conditions in your FSMs.

Feel free to customize this cheat sheet based on your specific needs and the topics covered in your lab. Good luck with your exam!