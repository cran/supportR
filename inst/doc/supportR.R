## ----knitr-mechanics, include = F---------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")

## ----pre-setup, echo = FALSE, message = FALSE---------------------------------
# devtools::install_github("njlyon0/supportR")

## ----setup--------------------------------------------------------------------
library(supportR)

## ----ex-data-pngn-------------------------------------------------------------
# Load library
library(palmerpenguins)

# Glimpse the penguins dataset
dplyr::glimpse(penguins)

## ----summary_table------------------------------------------------------------
# Summarize the data
summary_table(data = penguins, groups = c("species", "island"),
              response = "bill_length_mm", drop_na = T)

## ----diff_check---------------------------------------------------------------
# Make two vectors
vec1 <- c("x", "a", "b")
vec2 <- c("y", "z", "a")

# Compare them!
diff_check(old = vec1, new = vec2)

## ----num_check----------------------------------------------------------------
# Make a dataframe with non-numbers in a number column
fish <- data.frame('species' = c('salmon', 'bass', 'halibut', 'eel'),
                   'count' = c(1, '14x', '_23', 12))

# Use `num_check` to identify non-numbers
num_check(data = fish, col = "count")

## ----date_check---------------------------------------------------------------
# Make a dataframe including malformed dates
sites <- data.frame('site' = c("LTR", "GIL", "PYN", "RIN"),
                    'visit' = c('2021-01-01', '2021-01-0w', '1990', '2020-10-xx'))

# Now we can use our function to identify bad dates
date_check(data = sites, col = 'visit')

## ----date_format_guess--------------------------------------------------------
# Make a dataframe with dates in various formats and a grouping column
my_df <- data.frame('data_enterer' = c('person A', 'person B',
                                       'person B', 'person B',
                                       'person C', 'person D',
                                       'person E', 'person F',
                                       'person G'),
                    'bad_dates' = c('2022.13.08', '2021/2/02',
                                    '2021/2/03', '2021/2/04',
                                    '1899/1/15', '10-31-1901',
                                    '26/11/1901', '08.11.2004',
                                    '6/10/02'))

# Now we can invoke the function!
date_format_guess(data = my_df, date_col = "bad_dates",
                  group_col = "data_enterer", return = "dataframe")

# If preferred, do it without groups and return a vector
date_format_guess(data = my_df, date_col = "bad_dates",
                  groups = FALSE, return = "vector")

## ----theme_lyon, out.width = "50%"--------------------------------------------
# Load ggplot2
library(ggplot2)

# Create a plot
ggplot(penguins, aes(x = species, y = body_mass_g, fill = species)) +
  geom_boxplot(outlier.shape = 24) +
  theme_lyon()

## ----nms_ord, message = F, warning = F, results = 'hide', out.width="50%"-----
# Load data from the `vegan` package
utils::data("varespec", package = 'vegan')
resp <- varespec

# Make a columns to split the data into 4 groups
factor_4lvl <- c(rep.int("Trt_1", (nrow(resp)/4)),
                 rep.int("Trt_2", (nrow(resp)/4)),
                 rep.int("Trt_3", (nrow(resp)/4)),
                 rep.int("Trt_4", (nrow(resp)/4)))

# And combine them into a single data object
data <- cbind(factor_4lvl, resp)

# Actually perform multidimensional scaling
mds <- vegan::metaMDS(data[-1], autotransform = FALSE, 
                      expand = FALSE, k = 2, try = 10)

# With the scaled object and original dataframe we can use this function
nms_ord(mod = mds, groupcol = data$factor_4lvl,
        title = '4-Level NMS', leg_pos = 'topright',
        leg_cont = c('1', '2', '3', '4'))

## ----array_melt---------------------------------------------------------------
# Make data to fill the array
vec1 <- c(5, 9, 3)
vec2 <- c(10:15)

# Create dimension names (x = col, y = row, z = which matrix)
x_vals <- c("Col_1","Col_2","Col_3")
y_vals <- c("Row_1","Row_2","Row_3")
z_vals <- c("Mat_1","Mat_2")

# Make an array from these components
g <- array(data = c(vec1, vec2), dim = c(3, 3, 2),
           dimnames = list(x_vals, y_vals, z_vals))

# "Melt" the array into a dataframe
array_melt(array = g)

## ----rmd_export, eval = F-----------------------------------------------------
#  # Authorize R to interact with GoogleDrive
#  googledrive::drive_auth()
#  
#  # Use `rmd_export()` to knit and export an .Rmd file
#  rmd_export(rmd = "my_markdown.Rmd",
#             in_path = file.path("Folder in my WD with the .Rmd named in `rmd`"),
#             out_path = file.path("Folder in my WD to save the knit file to"),
#             out_name = "desired name for output",
#             out_type = "html",
#             drive_link = "<Full Google Drive link>")

