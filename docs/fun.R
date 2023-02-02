# ---------------------------------
# Code below from Patrick Breheny
# ---------------------------------

pal <- function(n, alpha=1)
{
  if (n==2) {
    val <- hcl(seq(15,375,len=4), l=60, c=150, alpha=alpha)[c(1,3)]
  } else val <- hcl(seq(15,375,len=n+1), l=60, c=150, alpha=alpha)[1:n]
  val
}
toplegend <- function(horiz=TRUE, ...) {
  if (par("oma")[3]==0) {
    x <- mean(par("usr")[1:2])
    yy <- transform.coord(par("usr")[3:4], par("plt")[3:4])
    y  <- mean(c(yy[2],par("usr")[4]))
    legend(x, y, xpd=NA, bty="n", xjust=0.5, yjust=0.5, horiz=horiz, ...)    
  } else {
    g <- par("mfrow")
    xx <- transform.coord(par("usr")[1:2], par("plt")[1:2])
    yy <- transform.coord(par("usr")[3:4], par("plt")[3:4])
    xxx <- transform.coord(xx, c(g[2]-1,g[2])/g[2])
    yyy <- transform.coord(yy, c(g[1]-1,g[1])/g[1])
    yyyy <- transform.coord(yyy, par("omd")[3:4])
    legend(mean(xxx), mean(c(yyy[2],yyyy[2])), xpd=NA, bty="n", xjust=0.5, yjust=0.5, horiz=horiz, ...)
  }
}
rightlegend <- function(...) {
  if (par("oma")[3]==0) {
    y <- mean(par("usr")[3:4])
    xx <- transform.coord(par("usr")[1:2], par("plt")[1:2])
    x <- mean(c(xx[2],par("usr")[2]))
    legend(x, y, xpd=NA, bty="n", xjust=0.5, yjust=0.5, ...)    
  } else {
    g <- par("mfrow")
    xx <- transform.coord(par("usr")[1:2], par("plt")[1:2])
    yy <- transform.coord(par("usr")[3:4], par("plt")[3:4])
    xxx <- transform.coord(xx, c(g[2]-1,g[2])/g[2])
    yyy <- transform.coord(yy, c(g[1]-1,g[1])/g[1])
    yyyy <- transform.coord(yyy, par("omd")[3:4])
    legend(mean(xxx), mean(c(yyy[2],yyyy[2])), xpd=NA, bty="n", xjust=0.5, yjust=0.5, ...)
  }  
}
transform.coord <- function(x,p) {
  ba <- (x[2]-x[1])/(p[2]-p[1])
  a <- x[1]-p[1]*ba
  b <- a + ba
  c(a,b)
}
plotL <- function(x, l) {
  if (is.matrix(l)) {
    L <- apply(l, 2, function(x) x/max(x))
    matplot(x, L, type='l', xlab=expression(lambda), ylab=expression(L(lambda)),
            las=1, col=pal(ncol(L)), lwd=3, lty=1, bty='n')
    if (!is.null(colnames(L))) toplegend(legend=colnames(L), lwd=3, col=pal(ncol(L)))
  } else {
    l <- l/max(l)
    plot(x, l, type='l', xlab=expression(lambda), ylab=expression(L(lambda)),
         las=1, col=pal(2)[2], lwd=3, bty='n')
  }
}
polygon.step <- function(x,y1,y2,border=FALSE,...)
  {
    nx <- length(x)
    ny <- length(y1)
    if (length(y2)!=ny) stop("y1 and y2 must be the same length")
    if (nx != (ny+1)) stop("x must be one longer than y")
    xx <- c(x[1],rep(x[-c(1,nx)],rep(2,nx-2)),x[nx])
    xxx <- c(xx,rev(xx))
    yy1 <- rep(y1,rep(2,ny))
    yy2 <- rep(y2,rep(2,ny))
    yyy <- c(yy1,rev(yy2))
    polygon(xxx,yyy,border=border,...)
  }
ciband.survfit <- function(fit, col, fun=as.numeric) {
  K <- length(fit$strata)
  if (K==0) {
    s <- c(0, length(fit$time))
    if (missing(col)) col <- rgb(0.5, 0.5, 0.5, alpha=0.3)
    K <- 1
  } else {
    s <- c(0, cumsum(fit$strata))
    if (missing(col)) col <- pal(K, alpha=0.4)
  }
  for (i in 1:K) {
    ind1 <- (s[i]+1):s[i+1]
    ind2 <- (s[i]+1):(s[i+1]-1)
    x <- c(0, fit$time[ind1])
    l <- fun(c(1, fit$lower[ind2]))
    u <- fun(c(1, fit$upper[ind2]))
    polygon.step(x, l, u, col=col[i])
  }
}
ciband.survfitms <- function(fit, col, fun=as.numeric) {
  if(length(fit$strata)) stop('Not implemented for stratified multi-state models')
  K <- ncol(fit$prev)
  if (missing(col)) col <- pal(K, alpha=0.4)
  n <- length(fit$time)
  for (k in 1:K) {
    polygon.step(fit$time, fit$lower[-n,k], fit$upper[-n,k], col=col[k])
  }
}
ciband <- function(obj,...) UseMethod("ciband")
