# Argument Type Deduction in C++ Templates

- `T&&` is a forwarding reference when `T` is a deduced, cv-unqualified template parameter. It accepts lvalues and rvalues, with **reference collapsing preserving** the argument’s value category. [Godbolt example](https://godbolt.org/z/scEE5W7rn)
- Otherwise, `T&&` is an rvalue reference.
