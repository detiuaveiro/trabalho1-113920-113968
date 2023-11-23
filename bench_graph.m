% Read the CSV file
data = readtable('test_results.csv', 'Format', '%f%f%f%f%f');

% Clean the data (remove rows with NaN)
data = rmmissing(data);

% Extract image size and the number of iterations
image_size = data.Var1;
iterations = data.Var5;

% Fit a linear model
linearModel = fitlm(image_size, iterations);
disp(linearModel);

% Coefficients for the line of best fit
coefficients = polyfit(image_size, iterations, 1);
fitLine = polyval(coefficients, image_size);

% Plot the data
figure;
plot(image_size, iterations, 'o', 'MarkerSize', 8); % Plotting the data points
hold on; % Keep the current plot
plot(image_size, fitLine, '-r'); % Plotting the line of best fit
hold off; % Release the plot

% Adding labels and title
xlabel('Image Size (pixels)');
ylabel('Number of Iterations');
title('Complexity Analysis');

% Display the linear equation on the graph
str = sprintf('y = %.2fx + %.2f', coefficients(1), coefficients(2));
text(mean(image_size), mean(iterations), str, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');

% Set axes limits (if needed)
xlim([min(image_size) max(image_size)]);
ylim([min(iterations) max(iterations)]);
