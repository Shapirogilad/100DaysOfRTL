# Day 16
Design and verify an APB master interface which generates an APB transfer using a command input:
| cmd_i | Comment |
|-------|---------|
| 2'b00 | No-operation |
| 2'b01 | APB Read from address 0xDEAD_CAFE |
| 2'b10 | Increment the previously read data and write to 0xDEAD_CAFE |
| 2'b11 | Invalid/Not possible |

## Interface Definition
- The `cmd_i` input remains stable until the APB transfer is complete