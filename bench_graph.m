% Read the CSV files
data_optimized = readtable('test_results.csv', 'Format', '%f%f%f%f%f');
data_unoptimized = readtable('test_results_first.csv', 'Format', '%f%f%f%f%f');

% Clean the data (remove rows with NaN)
data_optimized = rmmissing(data_optimized);
data_unoptimized = rmmissing(data_unoptimized);

% Sort the data by image size
data_optimized = sortrows(data_optimized, 'Var1');
data_unoptimized = sortrows(data_unoptimized, 'Var1');

% Extract image size and the number of iterations for both datasets
image_size_opt = data_optimized.Var1;
iterations_opt = data_optimized.Var5;
image_size_unopt = data_unoptimized.Var1;
iterations_unopt = data_unoptimized.Var5;

% Fit a linear model for both datasets
linearModelOpt = fitlm(image_size_opt, iterations_opt);
disp(linearModelOpt);
linearModelUnopt = fitlm(image_size_unopt, iterations_unopt);
disp(linearModelUnopt);

% Coefficients for the line of best fit for both datasets
coefficients_opt = polyfit(image_size_opt, iterations_opt, 1);
fitLineOpt = polyval(coefficients_opt, image_size_opt);
coefficients_unopt = polyfit(image_size_unopt, iterations_unopt, 1);
fitLineUnopt = polyval(coefficients_unopt, image_size_unopt);

% Plot the data
figure;
plot(image_size_opt, iterations_opt, 'o', 'MarkerSize', 8, 'MarkerFaceColor', 'blue'); % Data points for the optimized version
hold on;
plot(image_size_unopt, iterations_unopt, 'o', 'MarkerSize', 8, 'MarkerFaceColor', 'red'); % Data points for the unoptimized version

% Plotting the lines of best fit
plot(image_size_opt, fitLineOpt, '-b'); % Line for the optimized version
plot(image_size_unopt, fitLineUnopt, '-r'); % Line for the unoptimized version

% Adding labels, legend, and title
xlabel('Image Size (pixels)');
ylabel('Number of Iterations');
legend('Optimized Version', 'Line of Best Fit - Opt', 'Unoptimized Version', 'Line of Best Fit - Unopt', 'Location', 'best');
title('Complexity Analysis: Optimized vs. Unoptimized');
hold on;



% Ensure the aspect ratio is equal for X and Y axes to make the line diagonal
axis square;
grid on