import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  List<LeaveRequest> leaveRequests = [];
  List<Holiday> holidays = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: Admin-specific components
            // ...

            // TODO: Holidays
            Holidays(holidays: holidays),

            // TODO: Leave Requests
            LeaveRequests(
              leaveRequests: leaveRequests,
              onApprove: (int index) {
                setState(() {
                  leaveRequests[index].status = LeaveStatusType.approved;
                });
              },
              onReject: (int index) {
                setState(() {
                  leaveRequests[index].status = LeaveStatusType.rejected;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Holidays extends StatelessWidget {
  final List<Holiday> holidays;

  Holidays({required this.holidays});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Holidays',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Display holidays
            for (var holiday in holidays)
              ListTile(
                title: Text('Holiday: ${holiday.name}'),
                subtitle: Text('Date: ${holiday.date}'),
              ),
          ],
        ),
      ),
    );
  }
}

class Holiday {
  final String name;
  final String date;

  Holiday({required this.name, required this.date});
}

class LeaveRequests extends StatelessWidget {
  final List<LeaveRequest> leaveRequests;
  final Function(int) onApprove;
  final Function(int) onReject;

  LeaveRequests({
    required this.leaveRequests,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Leave Requests',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Display leave requests based on status
            for (var i = 0; i < leaveRequests.length; i++)
              if (leaveRequests[i].status == LeaveStatusType.pending)
                ListTile(
                  title: Text('Employee: ${leaveRequests[i].employeeName}'),
                  subtitle: Text('Leave Type: ${leaveRequests[i].leaveType}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () => onApprove(i),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => onReject(i),
                      ),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

class LeaveRequest {
  final String employeeName;
  final String leaveType;
  final String startDate;
  final String endDate;
  final String reason;
  LeaveStatusType status;

  LeaveRequest({
    required this.employeeName,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.status,
  });
}

enum LeaveStatusType {
  pending,
  approved,
  rejected,
}
