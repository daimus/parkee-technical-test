def analyze_sales_data(file_paths):
    all_data = []
    for file in file_paths:
        df = pd.read_csv(file)
        all_data.append(df)

    # Combine CSV
    combined_df = pd.concat(all_data, ignore_index=True)

    # Data Cleaning
    # 1. Drop rows with NaN in specified columns
    cleaned_df = combined_df.dropna(subset=['transaction_id', 'date', 'customer_id'])

    # 2. Convert 'date' column to datetime
    cleaned_df = cleaned_df.copy() # Add this line to create a copy
    cleaned_df['date'] = pd.to_datetime(cleaned_df['date'])

    # 3. Drop duplicates based on 'transaction_id', keeping the latest 'date'
    cleaned_df = cleaned_df.sort_values(by='date', ascending=False)
    cleaned_df = cleaned_df.drop_duplicates(subset='transaction_id', keep='first')

    # Calculate total sales for each transaction
    cleaned_df['total_sale'] = cleaned_df['quantity'] * cleaned_df['price']

    # 4. Calculate total sales per branch
    total_sales_per_branch = cleaned_df.groupby('branch')['total_sale'].sum().reset_index()
    total_sales_per_branch.rename(columns={'total_sale': 'total'}, inplace=True)

    # Save results to a new CSV file
    total_sales_per_branch.to_csv('total_sales_per_branch.csv', index=False)

    return total_sales_per_branch

# List of CSV files to process
csv_files = ['branch_a.csv', 'branch_b.csv', 'branch_c.csv']

# Run the analysis
result_df = analyze_sales_data(csv_files)
print(result_df)