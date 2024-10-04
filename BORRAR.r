a <- data.frame(
    a <- c(2, 14),
    b <- c(23, 61),
    c <- c(11, 90),
    d <- c(14, 4),
    e <- c(53, 2),
    f <- c(89, 11)
)

colnames(a) <- c("a", "b", "c", "d", "e", "f")

scatter.smooth(a)
