library(ggplot2)

todo <- readRDS("longitudes/todo.rds")

l1 <- nchar(todo[, 5])
años <- todo$año

l2_df <- data.frame(
    año = años,
    texto = l1
)

l3_df <- l2_df[order(l2_df$año), ]

plot(l3_df)

todo[2, 5]

l2_df[176, ]
