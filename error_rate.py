def calculate_error_rate(errors, total):
    """Calculate error rate as a percentage."""
    return (errors / total) * 100
print("error_rate_percent", calculate_error_rate(5, 100))
