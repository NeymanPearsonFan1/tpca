% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tpca.R
\name{tpca}
\alias{tpca}
\alias{tailorPCA}
\alias{tailoredPCA}
\title{Tailors the choice of principal components for change detection}
\usage{
tpca(cov_mat, change_distr = "full_uniform",
  divergence = "normal_hellinger", cutoff = 0.99,
  max_axes = ncol(cov_mat), n_sim = 10^3)
}
\arguments{
\item{cov_mat}{A covariance matrix, i.e., a numeric matrix that is positive
definite.}

\item{change_distr}{A string or a change distribution object. A string can be
used to choose among a set of already implemented distributions (see details).
Custom distributions can be specified by using the \code{\link{set_uniform_cd}}
function.}

\item{divergence}{A string specifying which divergence metric to use. 
Available options: 'normal_hellinger', 'normal_KL' and 'normal_bhat'.}

\item{cutoff}{A numeric between 0 and 1 governing how many principal axes to
retain.}

\item{max_axes}{An integer indicating the maximum number of axes that should be
returned regardless of what the cutoff is.}

\item{n_sim}{An integer specifying the number of simulation runs.}
}
\value{
\code{tpca} returns an S3 object of class "tpca". This is a list with 
the following components:
\describe{
  \item{\code{axes}}{A matrix with the chosen principal axes as rows, 
  ordered in decreasing order of sensitivity.}
  \item{\code{which_axes}}{A vector indicating which principal axes that were
  chosen in decreasing order of sensitivity.}
  \item{\code{prop_axes_max}}{A vector with the proportion of simulations each axis
  was the most sensitive one.}
  \item{\code{divergence_sim}}{A matrix containing all the simulated draws 
  from the divergence metric along each principal axis. It is of dimension 
  data_dim x n_sim.}
  \item{\code{change_type}}{A character vector indicating the type of change 
  for each iteration of the simulation.}
  \item{\code{change_sparsity}}{A numeric vector indicating the sparsity of 
  the change for each iteration of the simulation.}
}
}
\description{
\code{tpca} tailors the choice of principal components to keep when detection
of changepoints in the mean vector or covariance matrix is the aim. The
choice of principal axes to project data onto is based on a normal state
covariance matrix and a distribution over relevant change scenarios.
}
\details{
This method is based on simulating changes to a distribution, followed by 
measuring the principal axes' sensitivity to each change by a statistical 
divergence. The most sensitive axis is recorded in each simulated change to 
estimate the probability of an axis being the most sensitive one over the
range of changes specified by a change distribution.

Custom change distributions can be built by using the function 
\code{\link{set_uniform_cd}}. All components of the distribution are uniform,
but the probability/importance of each type of change can be specified, along
with the sparsity of the change, and all the sizes and directions of the 
changes. In each simulation run, after a change sparsity has been drawn,
which dimensions that are affected by a change is always randomized.
The more information about which changes that are of interest, the better and
less general the choice of axes will be.

Built in choices for change distributions are implemented as calls to
\code{\link{set_uniform_cd}}:
\describe{
  \item{"full_uniform" (default)}{\code{set_uniform_cd(data_dim)}}
  \item{"full_uniform_equal"}{\code{set_uniform_cd(data_dim, change_equal = TRUE)}}
  \item{"full_uniform_large"}{\code{set_uniform_cd(data_dim, mean_int = c(-3, 3),
                                                   sd_int  = c(4^(-1), 4),
                                                   cor_int = c(0, 0.5))}}
  \item{"full_uniform_small"}{\code{set_uniform_cd(data_dim, mean_int = c(-0.5, 0.5),
                                                   sd_int  = c(1.5^(-1), 1.5),
                                                   cor_int = c(0.5, 1))}}
  \item{"semisparse_uniform"}{\code{set_uniform_cd(data_dim, 
                                                   sparsities = 2:round(data_dim / 2))}}
  \item{"mean_only"}{\code{set_uniform_cd(data_dim, prob = c(1, 0, 0))}}
  \item{"semisparse_mean_only"}{\code{set_uniform_cd(data_dim, prob = c(1, 0, 0),
                                                     sparsities = 2:round(data_dim / 2))}}
  \item{"sd_only"}{\code{set_uniform_cd(data_dim, prob = c(0, 1, 0))}}
  \item{"semisparse_sd_only"}{\code{set_uniform_cd(data_dim, prob = c(0, 1, 0),
                                                     sparsities = 2:round(data_dim / 2))}}
  \item{"cor_only"}{\code{set_uniform_cd(data_dim, prob = c(0, 0, 1))}}
  \item{"semisparse_cor_only"}{\code{set_uniform_cd(data_dim, prob = c(0, 0, 1),
                                                     sparsities = 2:round(data_dim / 2))}}
}
See the references for more information.
}
\examples{
cor_mat <- tpca::rcor_mat(10)  # Generate random correlation matrix.
tpca(cor_mat)

}
\references{

}
