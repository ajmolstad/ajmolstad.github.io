ridge.cv.func <- function(X, y, lambda.vec, cv.index) {

  n <- dim(X)[1]
  p <- dim(X)[2]
  
  cv.func <- function(cv.index) {

        y.t.train <- y[-cv.index] - mean(y[-cv.index])
        y.test <- y[cv.index] - mean(y[-cv.index])

        x.bar.train <- apply(X[-cv.index,],2,mean)
        x.t.train <- X[-cv.index,] - tcrossprod(rep(1,n - length(cv.index)),x.bar.train)
        x.test <- X[cv.index,] - tcrossprod(rep(1,length(cv.index)),x.bar.train)

        q <- min(dim(x.t.train)[1] - 1, p - 1)
        rsvd <- svd(x=x.t.train, nu=q, nv=q)
        d <- rsvd$d[1:q]
        d.2.lam <- d^2 + rep(lambda.vec, rep(q,length(lambda.vec)))
        du.y <- as.vector(d*(crossprod(rsvd$u,y.t.train)))
        DU.y <- du.y/d.2.lam
        dim(DU.y) <- c(q, length(lambda.vec))
        b <- tcrossprod(rsvd$v,t(DU.y))
        pred.err <- (y.test - tcrossprod(x.test,t(b)))^2
        return(pred.err)
    }
                 
    result <- lapply(cv.index, cv.func)
    MSE <- colSums(do.call(rbind, result))
    cvErrs <- lapply(result, colSums)
    lambda.min <- lambda.vec[which(MSE==min(MSE))]
    return(list("lambda.min" = lambda.min, "MSE"= MSE, "cvErrs" = cvErrs))

}
